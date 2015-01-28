{**
 * Главная
 *
 * @parama array $topics
 * @parama array $paging
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
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

    <h1>Компонент <span>{ucfirst($current)}</span></h1>

    {include $path}
{/block}