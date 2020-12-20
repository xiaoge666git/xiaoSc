<?php

namespace app\api\controller;

use app\api\validata\User;
use library\Controller;
use think\App;
use think\console\command\optimize\Schema;
use think\facade\Cache;

class Login extends Base
{
    public function __construct(App $app)
    {
        parent::__construct($app);
    }

    public function login()
    {

        $name = input('post.name');
        $pwd = input('post.password');
        $res = db('sc_user')->where('name', $name)->where('password', md5($pwd))->find();
        if (empty($res)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '账号或密码错误']);
        } else if ($res['status'] == 1) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '账号已封禁']);
        } else {
            $data = [
                'id' => $res['id'],
                'nick_name' => $res['nick_name'],
                'sex' => $res['sex'],
                'profile_picture' => $res['profile_picture'],
                'vip_validity_time' => $res['vip_validity_time'],
                'money' => $res['money'],
                'points' => $res['points'],
            ];
            //设置缓存 记录用户是否登录
            Cache::tag('is_login')->set(md5($res['id']), $res['id']);
//               var_dump(    Cache::tag('is_login')->get(md5($res['id'])));

            $this->ajaxReturn(['error_code' => 0, 'msg' => '登录成功', 'data' => $data, 'token' => md5($res['id']),]);
        }

    }

    //注册接口
    public function register()
    {

        $name = input('post.name', '', 'trim');
        $pwd = input('post.password', '', 'trim');
        $repwd = input('post.repassword', '', 'trim');
//var_dump(['name'=>$name,'password'=>$pwd,'repassword'=>$repwd]);

//die();
        $res = db('sc_user')->where('name', $name)->find();
        if (!empty($res)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '已有该用户']);
        } else {
            $vauser = validate('User');

//         var_dump($vauser->scene('register')->check(['name'=>$name,'password'=>$pwd,'repassword'=>$repwd]));
//         die();


            if ($vauser->scene('register')->check(['name' => $name, 'password' => $pwd, 'repassword' => $repwd])) {

                $res = db('sc_user')->insert(['name' => $name, 'password' => md5($pwd)]);

                if ($res) {
                    $this->ajaxReturn(['error_code' => 0, 'msg' => '注册成功']);
                }
            } else {

                $this->ajaxReturn(['error_code' => 1, 'msg' => $vauser->getError()]);
            }

        }

    }

    //退出登录
    public function loginout()
    {
//可以使用redis代替
        Cache::tag('is_login')->rm(md5($this->userInfo['id']));

//        var_dump(Cache::tag('is_login')->get(md5($this->userInfo['id'])));
        $this->ajaxReturn(['error_code' => 0, 'msg' => '退出成功']);

    }
}