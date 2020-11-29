<?php


namespace app\api\controller;


use library\Controller;
use think\facade\Session;


class Base extends Controller
{

    public function __construct()
    {
        parent::__construct();

        if (Session::has('moble_user')){
            $returnData=[
                'error_code'=>'2',
                'msg'=>'请登录！！！'
            ];
            $this->ajaxReturn($returnData);
        }
    }
    public function ajaxReturn($data){
        header('Content-Type:application/json; charset=utf-8');
        exit(json_encode($data));
    }

}