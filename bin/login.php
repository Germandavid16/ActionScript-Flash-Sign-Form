<?
// Авторизация
# Функция для генерации случайной строки
function generateCode($length=6) {
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRQSTUVWXYZ0123456789";
    $code = "";
    $clen = strlen($chars) - 1;  
	while (strlen($code) < $length) {
        $code .= $chars[mt_rand(0,$clen)];  
    }
    return $code;
}

# Соединямся с БД
mysql_connect("localhost", "host6519_test", "test123");
mysql_select_db("host6519_test");
# Вытаскиваем из БД запись, у которой логин равняеться введенному
$query = mysql_query("SELECT user_id, user_password FROM users WHERE user_login='".mysql_real_escape_string($_POST['login'])."' LIMIT 1");
$data = mysql_fetch_assoc($query);
# Сравниваем пароли
if($data['user_password'] === md5(md5($_POST['password'])))
{
	# Генерируем случайное число и шифруем его
	$hash = md5(generateCode(10));
	if(!@$_POST['not_attach_ip'])
	{
		# Если пользователя выбрал привязку к IP
		# Переводим IP в строку
		$insip = ", user_ip=INET_ATON('".$_SERVER['REMOTE_ADDR']."')";
	}
	# Записываем в БД новый хеш авторизации и IP
	mysql_query("UPDATE users SET user_hash='".$hash."' ".$insip." WHERE user_id='".$data['user_id']."'");
	# Ставим куки
	setcookie("id", $data['user_id'], time()+60*60*24*30);
	setcookie("hash", $hash, time()+60*60*24*30);
	# рапортуем что все гуд
	print "ok";
}
else
{
	print "Вы ввели неправильный логин/пароль";
}
?>