<?php


namespace app\api\controller;


use library\Controller;
use think\App;
use think\facade\Session;


class Base extends Controller
{

    public $noNeedLogin = ['login', 'register','loginout'];

    public function __construct(App $app)
    {
        parent::__construct($app);
        $currentAction = request()->action();
        $isCheckLogin = !in_array($currentAction, array_map('strtolower', $this->noNeedLogin));
        if ($isCheckLogin) {
            if (Session::has('u_id', 'xiao')) {
                $returnData = [
                    'error_code' => '0',
                    'msg' => '请登录！！！'
                ];

                $this->ajaxReturn($returnData);
            }
        }

    }

    public function ajaxReturn($data)
    {
        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($data));
    }

}