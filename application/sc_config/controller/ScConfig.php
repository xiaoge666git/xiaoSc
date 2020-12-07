<?php

namespace app\sc_config\controller;

use library\Controller;
use think\console\command\optimize\Schema;

class ScConfig extends Controller
{
    protected $table = 'sc_config';

    public function index()
    {
        $res = db($this->table)
            ->select();
        $this->assign('res', $res);
      return  $this->fetch('index');
    }

    public function edit()
    {
        $data=input();

        db($this->table)->where('config_key','money_than_poing')->update(['config_val'=>$data['money_than_poing']]);
        db($this->table)->where('config_key','vip_config')->update(['config_val'=>$data['vip_config']]);

        $res = db($this->table)
            ->select();
        $this->assign('res', $res);
        return  $this->fetch('index');


//        var_dump();
//        die();
//        $money['money_than_poing'] = input('post.money_than_poing', 10, 'intval');
//        $money['vip_config'] = input('post.vip_config', 10, 'intval');
//        $res = db($this->table)
//            ->select();
//
//        $this->assign('res', $res);
//        $this->fetch('edit');
    }


}