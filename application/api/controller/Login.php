<?php

namespace app\api\controller;

use library\Controller;

class Login extends Base
{
    public function __construct()
    {
        parent::__construct();
    }

    public function login()
    {

        $name = input('post.name');
        $pwd = input('post.password');

        return $this->ajaxReturn(['name' => $name, 'pwd' => $pwd, 'id' => 1]);
    }
}