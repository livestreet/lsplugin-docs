<?php

class PluginDocs_ActionDocs extends ActionPlugin {

    /**
     * Путь до шаблона с документацией относительно компонента
     *
     * @var string
     */
    private $guide = '/docs/guide.tpl';

    /**
     * Инициализация экшена
     */
    public function Init()
    {
        $this->SetDefaultEvent('index');

        // Получаем компоненты с документацией
        $this->components = $this->getDocumentedComponents();

        if ( ! $this->components )
        {
            return parent::EventNotFound();
        }
    }

    /**
     * Регистрируем евенты
     */
    protected function RegisterEvent()
    {
        $this->AddEvent('index', 'EventIndex');
        $this->AddEventPreg('/^[\w\-\_]+$/i', '/^$/i', 'EventIndex');
    }

    /**
     * Главная
     */
    protected function EventIndex()
    {
        // Активный компонент
        $current = $this->sCurrentEvent;

        // Если находимся на главной странице,
        // то делаем активным первый компонент
        if ($current == 'index')
        {
            $current = $this->components[0];
        }

        // Проверяем существование компонента
        if ( ! in_array($current, $this->components))
        {
            return parent::EventNotFound();
        }

        // Добавляем блок с навигацией в сайдбар
        $this->Viewer_AddBlock('right', 'nav', array('plugin' => Plugin::GetPluginCode($this)));

        // Устанавливаем переменные шаблона
        $this->Viewer_Assign('current', $current);
        $this->Viewer_Assign('path', $this->getGuidePath($current));

        $this->SetTemplateAction('index');
    }

    /**
     * Получает компоненты с документацией
     *
     * @return array
     */
    private function getDocumentedComponents()
    {
        $components = array();

        foreach (Config::Get('components') as $component)
        {
            if ($this->isDocumented($component))
            {
                $components[] = $component;
            }
        }

        // Сортируем компоненты в алфавитном порядке
        sort($components);

        return $components;
    }

    /**
     * Проверяет документирован компонент или нет
     *
     * @param string $component Название компонента
     * @return bool
     */
    private function isDocumented($component)
    {
        return $this->Viewer_TemplateExists($this->getGuidePath($component));
    }

    /**
     * Получает системный путь до шаблона с документацией
     *
     * @param string $component Название компонента
     * @return string
     */
    private function getGuidePath($component)
    {
        return $this->Component_GetPath($component) . $this->guide;
    }

    /**
     * Выполняется при завершении работы экшена
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('components', $this->components);
    }
}