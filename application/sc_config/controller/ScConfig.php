<?php

namespace app\sc_cnfig\controller;

use library\Controller;

class ScConfig extends Controller
{
    protected $table = 'sc_config';

    public function index()
    {
        $this->_query($this->table)
            ->page();
    }

}