$enabledUsers = Get-ADUser -Filter "*" -Properties samaccountname, employeeNumber, pager

# 出力ファイルのパス
$outputFilePath = "C:\path\outputfile.txt"
$serverCom = "C:\Program Files\PaperCut MF\server\bin\win\server-command.exe"

# ファイルに書き込むための空の文字列を作成
$output = ""

foreach ($user in $enabledUsers) {
    $samaccountname = $user.samaccountname
    $employeeNumber = $user.employeeNumber
    $pager = $user.pager

    # 結果を文字列に追加
    $output += "$samaccountname`t$employeeNumber$pager`r`n"
}

# 結果をファイルに書き込み
$output | Out-File -FilePath $outputFilePath -Encoding UTF8

# サーバコマンドの実行
cmd.exe /c $serverCom batch-import-user-card-id-numbers $outputFilePath TRUE


