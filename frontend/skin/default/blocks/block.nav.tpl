{**
 * Навигация
 *}

{capture 'block_content'}
    {$items = []}

    {foreach $components as $component}
        {$items[] = [ 'name' => $component, 'url' => "{router page='docs'}{$component}", 'text' => ucfirst(str_replace('-', ' ', $component)) ]}
    {/foreach}

    {component 'nav'
        name       = 'docs'
        activeItem = $current
        mods       = 'pills stacked'
        classes    = 'user-nav'
        items      = $items}
{/capture}

{component 'block' mods='nopadding transparent' content=$smarty.capture.block_content}