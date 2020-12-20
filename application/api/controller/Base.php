<?php


namespace app\api\controller;


use library\Controller;
use think\App;
use think\facade\Cache;
use think\facade\Session;


class Base extends Controller
{
    //不需要登录的方法 不需要验证token
    public $noNeedLogin = ['login', 'register'];

    //用户信息 登录成功后赋值
    public $userInfo;

    public function __construct(App $app)
    {

        parent::__construct($app);
        $currentAction = request()->action();
        $isCheckLogin = !in_array($currentAction, array_map('strtolower', $this->noNeedLogin));

        if ($isCheckLogin) {

            $is_token = Cache::tag('is_login')->get(request()->header('token'));
            if (!$is_token) {
                $returnData = ['error_code' => '1001', 'msg' => '请登录!!!'];
                $this->ajaxReturn($returnData);
            }
        }
//        var_dump(request()->header('token'));
//        var_dump(Cache::tag('is_login')->get(request()->header('token')));
        $this->userInfo = db('sc_user')->where('id', Cache::tag('is_login')->get(request()->header('token')))->find();
    }

    public function ajaxReturn($data)
    {
        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($data));
    }

}