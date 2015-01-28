{**
 * Навигация
 *}

{extends 'components/block/block.tpl'}

{block 'block_options' append}
    {$mods = 'nopadding transparent'}
{/block}

{block 'block_content'}
    {$items = []}

    {foreach $components as $component}
        {$items[] = [ 'name' => $component, 'url' => "{router page='docs'}{$component}", 'text' => ucfirst($component) ]}
    {/foreach}

    {component 'nav'
        name       = 'docs'
        activeItem = $current
        mods       = 'pills stacked'
        classes    = 'user-nav'
        items      = $items}
{/block}