<?php


namespace app\common\model;


use think\Model;

class Student extends Model
{
    public function sClass()
    {
        return $this->hasOne('SClass','id','c_id');
    }

}