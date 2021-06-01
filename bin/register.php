<?
// Регистрация
# Соединямся с БД
mysql_connect("localhost", "host6519_test", "test123");
mysql_select_db("host6519_test");
$err = '';
# проверям логин
if(strlen($_POST['login']) < 3 or strlen($_POST['login']) > 30)
{
	print "Логин должен быть не меньше 3-х символов и не больше 30";
}
else
{
	# проверяем, не сущестует ли пользователя с таким именем
	$query = mysql_query("SELECT COUNT(user_id) FROM users WHERE user_login='".mysql_real_escape_string($_POST['login'])."'");
	if(mysql_result($query, 0) > 0)
	{
		print "Пользователь с таким логином уже существует в базе данных";
	}
	else
	{
		# Если нет ошибок, то добавляем в БД нового пользователя
		$login = $_POST['login'];
		# Убераем лишние пробелы и делаем двойное шифрование
		$password = md5(md5(trim($_POST['password'])));
		mysql_query("INSERT INTO users SET user_login='".$login."', user_password='".$password."'");
		# header("Location: login.php"); exit();
		print "ok";
	}
}
?>