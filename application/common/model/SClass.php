<?php


namespace app\common\model;


use think\Model;

class sClass extends Model
{
public function  student(){
    $this->hasMany('student','class','id');
}
}