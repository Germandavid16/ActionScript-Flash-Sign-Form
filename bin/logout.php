<?
// Расзогинивание, убиваем куки
if (isset($_COOKIE['id']) and isset($_COOKIE['hash']))
{
	setcookie("id", "", time() - 3600*24*30*12);
	setcookie("hash", "", time() - 3600*24*30*12);
}
?>