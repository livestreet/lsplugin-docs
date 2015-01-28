<?php

if ( ! class_exists('Plugin'))
{
    die('Hacking attempt!');
}

class PluginDocs extends Plugin {

    /**
     * Активация плагина
     *
     * @return bool
     */
    public function Activate()
    {
        return true;
    }

    /**
     * Деактивация плагина
     *
     * @return bool
     */
    public function Deactivate()
    {
        return true;
    }

    /**
     * Инициализация плагина
     */
    public function Init()
    {
        $this->Viewer_AppendStyle(Plugin::GetTemplatePath(__CLASS__) . 'css/style.css');
    }
}