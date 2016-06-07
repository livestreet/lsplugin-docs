{**
 * Навигация
 *}

<ul class="p-docs-nav">
    {foreach $docsComponents as $component}
        <li class="p-docs-nav-item {if $docsCurrentComponent == $component}active{/if}">
            <a href="{router page='docs'}{$component}" class="p-docs-nav-item-link">
                {$component}
            </a>
        </li>
    {/foreach}
</ul>