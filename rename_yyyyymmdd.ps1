$directory = "$PSScriptRoot\test"
Write-Host "directory" $directory
# �Â����t����͂Ƃ��Ď󂯎��
$oldDate = Read-Host "�ύX�������N������YYYYMMDD�`���œ��͂��Ă�������(��:20241101)"
# �V�������t����͂Ƃ��Ď󂯎��
$newDate = Read-Host "�V�����N������YYYYMMDD�`���œ��͂��Ă�������(��:20241201)"
Write-Host "$oldDate -> $newDate"

if ($newDate -match "^\d{8}$" -and $oldDate -match "^\d{8}$") {�@
    # �w�肳�ꂽ oldDate �Ɉ�v����t�@�C�����擾
    $files = Get-ChildItem -Path $directory -Filter "*$oldDate*"
    
    if ($files.Count -eq 0) {
        # �t�@�C����������Ȃ��ꍇ
        Write-Host "$oldDate ���܂܂��t�@�C�������݂��܂��� " -ForegroundColor Red
    } else {
        # ���������ꍇ�̏���
        foreach ($file in $files) {
            # �V�����t�@�C�������쐬
            $newFileName = $file.Name -replace $oldDate, $newDate
            
            # �V�����t�@�C���̃t���p�X���쐬
            $newFilePath = Join-Path -Path $directory -ChildPath $newFileName
            
            # �t�@�C������ύX�i���l�[���j
            attrib -r $file.FullName
            Rename-Item -Path $file.FullName -NewName $newFileName
            
            # ���ʂ�\��
            Write-Host "Renamed: $($file.Name) -> $newFileName"
        }
    }
} else {
    Write-Host "YYYYMMDD�̌`���œ��͂��Ă�������(��:20241101)" -ForegroundColor Red
}