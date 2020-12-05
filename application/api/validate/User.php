<?php

namespace app\api\validate;

use think\Validate;

class User extends Validate
{
    protected $rule = [
        'name' => 'require|max:10',
        'password' => 'require|length:4,16|confirm',
        'nick_name' => 'require|length:4,16',
        'repassword' => 'require|confirm:password'
    ];

    protected $message = [
        'name.require' => '账号名为空',
        'name.max' => '账号名最长10',
        'password.require' => '密码为空',
        'password.length' => '密码长度在4至16个字符之间',
        'nick_name.length' => '昵称长度在4至16个字符之间',
        'password.confirm' => '两次密码不一致'
    ];

    protected $scene = [
        'login' => ['name', 'password'],
        'register' => ['name', 'passowrd', 'repassword']
    ];
}