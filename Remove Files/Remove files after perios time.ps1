

Get-ChildItem –Path "\\simplexserver\Bentley\JOBS2\Cancelled" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item

Get-ChildItem –Path "\\simplexserver\Bentley\JOBS2\Completed" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item

Get-ChildItem –Path "\\simplexserver\Bentley\JOBS2\Failed" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item