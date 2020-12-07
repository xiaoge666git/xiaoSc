<?php


namespace app\api\controller;


use library\Controller;
use think\App;
use think\facade\Session;


class Base extends Controller
{
    //不需要登录的方法
    public $noNeedLogin = ['login', 'register', 'loginout'];
    //用户信息 登录成功后赋值
    public $userInfo;

    public function __construct(App $app)
    {

        parent::__construct($app);
        $currentAction = request()->action();
        $isCheckLogin = !in_array($currentAction, array_map('strtolower', $this->noNeedLogin));
        if ($isCheckLogin) {
            if (!Session::has('u_id', 'xiao')) {
                $returnData = [
                    'error_code' => '0',
                    'msg' => '请登录！！！'
                ];

                $this->ajaxReturn($returnData);
            }

        }
        $this->userInfo = db('sc_user')->where('id', session('u_id','','xiao'))->find();
    }

    public function ajaxReturn($data)
    {
        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($data));
    }

}