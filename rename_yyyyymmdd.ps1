$directory = "$PSScriptRoot\test"
Write-Host "directory" $directory
# 古い日付を入力として受け取る
$oldDate = Read-Host "変更したい年月日をYYYYMMDD形式で入力してください(例:20241101)"
# 新しい日付を入力として受け取る
$newDate = Read-Host "新しい年月日をYYYYMMDD形式で入力してください(例:20241201)"
Write-Host "$oldDate -> $newDate"

if ($newDate -match "^\d{8}$" -and $oldDate -match "^\d{8}$") {　
    # 指定された oldDate に一致するファイルを取得
    $files = Get-ChildItem -Path $directory -Filter "*$oldDate*"
    
    if ($files.Count -eq 0) {
        # ファイルが見つからない場合
        Write-Host "$oldDate が含まれるファイルが存在しません " -ForegroundColor Red
    } else {
        # 見つかった場合の処理
        foreach ($file in $files) {
            # 新しいファイル名を作成
            $newFileName = $file.Name -replace $oldDate, $newDate
            
            # 新しいファイルのフルパスを作成
            $newFilePath = Join-Path -Path $directory -ChildPath $newFileName
            
            # ファイル名を変更（リネーム）
            attrib -r $file.FullName
            Rename-Item -Path $file.FullName -NewName $newFileName
            
            # 結果を表示
            Write-Host "Renamed: $($file.Name) -> $newFileName"
        }
    }
} else {
    Write-Host "YYYYMMDDの形式で入力してください(例:20241101)" -ForegroundColor Red
}