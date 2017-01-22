{**
 * Главная
 *}

{extends "{$aTemplatePathPlugin.docs}layouts/layout.base.tpl"}

{block 'layout_options' append}
    {$classes = "$classes p-docs-page"}
{/block}

{block 'layout_content'}
    <script>
        domReady(function() {
            $('.js-plugin-docs-api-file').lsDetailsGroup({
                single: false
            });
        });
    </script>

    {function test_heading}
        <div class="p-docs-heading p-docs-heading-h2">{$text}</div>
    {/function}

    {function test_example code='' content=''}
        <div class="p-docs-example">
            <div class="p-docs-example-title">Пример</div>

            <div class="p-docs-example-content">
                {$content}
            </div>

            {if $code}
                <div class="p-docs-example-code">
                    <pre><code>{$code|escape}</code></pre>
                </div>
            {/if}
        </div>
    {/function}

    {function test_code}
        <pre><code>{rtrim($code|escape)}</code></pre>
    {/function}

    {function plugin_docs_params params=[]}
        <table class="ls-table">
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
        <table class="ls-table">
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

    <div class="p-docs-heading p-docs-component-title">
        Компонент
        <span class="p-docs-component-name">{$docsCurrentComponent}</span>
    </div>

    {component 'nav'
        name       = 'plugin_docs'
        mods       = 'pills'
        activeItem = $docsNavActiveItem
        items      = $docsNavItems}

    {include $docsPath}
{/block}