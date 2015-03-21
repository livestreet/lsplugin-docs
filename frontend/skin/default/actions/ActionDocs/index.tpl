{**
 * Главная
 *
 * @parama array $topics
 * @parama array $paging
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <script>
        jQuery(function($) {
            $('.js-plugin-docs-api-file').lsDetailsGroup({
                single: false
            });
        });
    </script>

    {function test_heading}
        <br><h2>{$text}</h2>
    {/function}

    {function test_example}
        {$code = $code|default:$content}

        <div class="test-example">
            <div class="test-example-title">Пример</div>

            <div class="test-example-content">
                {$content}
            </div>

            {if $code}
                <div class="test-example-code">
                    <pre><code>{$code|escape}</code></pre>
                </div>
            {/if}
        </div>
    {/function}

    {function test_code}
        <pre><code>{rtrim($code|escape)}</code></pre>
    {/function}

    {function plugin_docs_params params=[]}
        <table class="table">
            <thead>
                <tr>
                    <th>Параметр</th>
                    <th>Тип</th>
                    <th>По&nbsp;умолчанию</th>
                    <th>Описание</th>
                </tr>
            </thead>
            <tbody>
                {foreach $params as $param}
                    <tr>
                        <td><code>{$param[0]}</code></td>
                        <td>{$param[1]}</td>
                        <td>{$param[2]}</td>
                        <td>{$param[3]}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    {/function}

    {function plugin_docs_params_short params=[]}
        <table class="table">
            <thead>
                <tr>
                    <th>Параметр</th>
                    <th>Описание</th>
                </tr>
            </thead>
            <tbody>
                {foreach $params as $param}
                    <tr>
                        <td><code>{$param[0]}</code></td>
                        <td>{$param[1]}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    {/function}

    {function plugin_docs_api_file title='' items=[]}
        {component 'details' template='group' classes='js-plugin-docs-api-file' items=$items}
    {/function}

    <h1>Компонент <span>{ucfirst($docsCurrentComponent)}</span></h1>

    {component 'nav'
        name       = 'plugin_docs'
        mods       = 'pills'
        activeItem = $docsNavActiveItem
        items      = $docsNavItems}

    {include $docsPath}
{/block}