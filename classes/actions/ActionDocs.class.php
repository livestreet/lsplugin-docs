<?php

class PluginDocs_ActionDocs extends ActionPlugin {

    /**
     * Список путей до шаблонов с документацией относительно компонента (без расширения)
     *
     * @var array
     */
    private static $docs = [
        // Док-ия
        'guide' => 'docs/guide',
        // API компонента
        'api' => 'docs/api'
    ];

    /**
     * Инициализация экшена
     */
    public function Init()
    {
        $this->SetDefaultEvent('index');

        // Залогиненый пользователь
        $user = $this->User_GetUserCurrent();

        // Получаем компоненты с документацией
        $this->components = $this->getDocumentedComponents();

        // Проверяем наличие компонентов и
        // разрешаем доступ только администраторам
        if ( ! $this->components || ! $user || ! $user->isAdministrator() )
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
        $this->AddEventPreg('/^[\w\-\_]+$/i', '/^(guide|api)?$/', 'EventIndex');
    }

    /**
     * Главная
     */
    protected function EventIndex()
    {
        // Активный компонент
        // Если находимся на главной странице,
        // то делаем активным первый компонент
        $component = $this->sCurrentEvent == 'index' ? $this->components[0] : $this->sCurrentEvent;

        // Проверяем существование компонента
        if ( ! in_array($component, $this->components))
        {
            return parent::EventNotFound();
        }

        // Текущая страница, guide или api
        // По умолчанию показываем страницу с док-ей (guide)
        $navActiveItem = $this->GetParamEventMatch(0, 0) ?: 'guide';

        // Добавляем блок с навигацией в сайдбар
        $this->Viewer_AddBlock('sidebar', 'nav', [ 'plugin' => Plugin::GetPluginCode($this) ]);

        // Устанавливаем переменные шаблона
        $this->Viewer_Assign('docsCurrentComponent', $component);
        $this->Viewer_Assign('docsPath', $this->getDocPath($component, $navActiveItem));
        $this->Viewer_Assign('docsNavActiveItem', $navActiveItem);
        $this->Viewer_Assign('docsNavItems', [
            [ 'name' => 'guide', 'url' => $this->getDocWebPath($component, 'guide'), 'text' => 'Guide' ],
            [ 'name' => 'api', 'url' => $this->getDocWebPath($component, 'api'), 'text' => 'API', 'is_enabled' => $this->getDocPath($component, 'api') ],
        ]);

        $this->SetTemplateAction('index');
    }

    /**
     * Получает компоненты с документацией
     *
     * @return array
     */
    private function getDocumentedComponents()
    {
        // Отфильтровываем компоненты с документацией
        $components = array_filter(Config::Get('components'), [ $this, 'isDocumented' ]);

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
        return $this->getDocPath($component);
    }

    /**
     * Получает системный путь до шаблона с документацией
     *
     * @param string $component Название компонента
     * @param string $doc Страница, например guide или api
     * @return string|false
     */
    private function getDocPath($component, $doc = 'guide')
    {
        return $this->Component_GetTemplatePath($component, self::$docs[$doc]);
    }

    /**
     * Получает веб путь до страницы с документацией
     *
     * @param string $component Название компонента
     * @param string $doc Страница, например guide или api
     * @return string
     */
    private function getDocWebPath($component, $doc = 'guide')
    {
        return Router::GetPath('docs') . "{$component}/{$doc}/";
    }

    /**
     * Выполняется при завершении работы экшена
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('docsComponents', $this->components);
    }
}