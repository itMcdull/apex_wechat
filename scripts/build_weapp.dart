import 'dart:io';
import 'package:path/path.dart' as p;

main(List<String> args) {
  _checkPubspec();
  _createBuildDir();
  _copyWeappSource();
  _buildDartJS();
}

_checkPubspec() {
  if (!File('pubspec.yaml').existsSync()) {
    throw '''
    The pubspec.yaml not exists, confirm you are in the mpflutter project root dir. [EN]
    pubspec.yaml 文件不存在，请确认您当前处于 mpflutter 工程根目录。[ZH]
    ''';
  }
}

_createBuildDir() {
  if (!Directory('build').existsSync()) {
    Directory('build').createSync();
  } else {
    Directory('build').deleteSync(recursive: true);
    Directory('build').createSync();
  }
}

String _buildDartJS() {
  Process.runSync(
      'dart2js',
      [
        'lib/main.dart',
        '-O4',
        '-Ddart.vm.product=true',
        '--csp',
        '-o',
        'build/main.dart.js'
      ],
      runInShell: true);
  var codeSource = File('./build/main.dart.js').readAsStringSync();
  codeSource = codeSource.replaceAll(RegExp(r"\(\)\n//#"), "\n//#");
  codeSource = "self = global.self;\nmodule.exports.main = " + codeSource;
  File('./build/main.dart.js').writeAsStringSync(codeSource);
  var appSource = File('./build/app.js').readAsStringSync();
  appSource = appSource.replaceAll("var dev = true;", "var dev = false;");
  File('./build/app.js').writeAsStringSync(appSource);
  Process.runSync(
    'flutter',
    [
      'build',
      'bundle',
    ],
    runInShell: true,
  );
  if (Directory('./build/flutter_assets').existsSync()) {
    Directory('./build/flutter_assets').renameSync('./build/assets');
  }
  _removeFiles([
    './build/assets/isolate_snapshot_data',
    './build/assets/kernel_blob.bin',
    './build/assets/vm_snapshot_data',
    './build/snapshot_blob.bin.d'
  ]);
  return File('./build/assets/.last_build_id')
      .readAsStringSync()
      .substring(0, 6);
}

_copyWeappSource() {
  _copyPathSync('./weapp', './build/');
}

_removeFiles(List<String> files) {
  files.forEach((element) {
    try {
      File(element).deleteSync();
    } catch (e) {}
  });
}

void _copyPathSync(String from, String to) {
  Directory(to).createSync(recursive: true);
  for (final file in Directory(from).listSync(recursive: true)) {
    final copyTo = p.join(to, p.relative(file.path, from: from));
    if (file is Directory) {
      Directory(copyTo).createSync(recursive: true);
    } else if (file is File) {
      File(file.path).copySync(copyTo);
    } else if (file is Link) {
      Link(copyTo).createSync(file.targetSync(), recursive: true);
    }
  }
}
