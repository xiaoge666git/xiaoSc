<?php

namespace app\api\controller;

use app\api\validata\User;
use library\Controller;
use think\App;
use think\console\command\optimize\Schema;

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
            $this->ajaxReturn(['error_code' => 0, 'msg' => '账号或密码错误']);
        } else if ($res['status'] == 1) {
            $this->ajaxReturn(['error_code' => 0, 'msg' => '账号已封禁']);
        } else {
            session('u_id', $res['id'], 'xiao');
            $data = [
                'id' => $res['id'],
                'nick_name' => $res['nick_name'],
                'sex' => $res['sex'],
                'profile_picture' => $res['profile_picture'],
                'vip_validity_time' => $res['vip_validity_time'],
                'money' => $res['money'],
                'points' => $res['points'],
            ];
            $this->ajaxReturn(['error_code' => 1, 'msg' => '登录成功', 'data' =>$data]);
        }

    }
    //注册接口
    public function register(){

     $name=input('post.name');
     $pwd=input('post.password');
     $repwd=input('post.repassword');


     $res=db('sc_user')->where('name',$name)->find();
     if (!empty($res)){
         $this->ajaxReturn(['error_code'=>0,'msg'=>'已有该用户']);
     }else{
         $vauser=validate('User');

         if ($result=$vauser->scene('login')->check(['name'=>$name,'password'=>$pwd,'repassword'=>$repwd])){

             $res=db('sc_user')->insert(['name'=>$name,'password'=>$pwd]);

             if ($res){
                 $this->ajaxReturn(['error_code'=>1,'msg'=>'注册成功']);
             }
         }else{

                 $this->ajaxReturn(['error_code'=>0,'msg'=>$vauser->getError()]);
         }

     }

    }
    //退出登录
    public function loginout(){
        session('u_id', null, 'xiao');
        $this->ajaxReturn(['error_code'=>1,'msg'=>'退出成功']);
//        $this->request('/mobie/login');
    }
}