#!/usr/bin/env php
<?php

define('TEMPLATE_PATH', "{$_SERVER['HOME']}/Templates");
define('DATE_REGEX', "\d{4}-\d{2}-\d{2}");
define('DATE_FORMAT', "Y-m-d");

exit(main($argc, $argv));

function main(int $argc, array $argv)
{
    $updated = [];

    foreach (get_template_files() as $file) {
        if (filename_starts_with_date($file)) {
            $updated[] = [
                'file' => update_filename_date($file),
                'message' => "Updated filename",
            ];
        }

        if (is_markdown($file) && has_markdown_headers($file)) {
            $updated[] = [
                'file' => update_markdown_headers($file),
                'message' => "Updated markdown headers",
            ];
        }
    }

    sprintf("Updated %d files:\n", count($updated));

    foreach ($updated as $row) {
        sprintf("\t%s: %s\n", $row['file'], $row['message']);
    }

    return 0;
}

function get_template_files(): Generator
{
    $it = new RecursiveDirectoryIterator(TEMPLATE_PATH);
    $it = new RecursiveIteratorIterator($it);
    $it = new CallbackFilterIterator($it, fn($file) => $file->isFile() && $file->isWriteable());

    yield from $it;
}

function filename_starts_with_date(SplFileInfo $file): bool
{
    // ISO8601 (only date)
    return preg_match('/^' . DATE_REGEX . '/', $file->getFilename());
}

function update_filename_date(SplFileInfo $file): SplFileInfo
{
    return preg_replace('/^(' . DATE_REGEX . ')/', date(DATE_FORMAT), $file->getFilename());
}

function is_markdown(SplFileInfo $file): bool
{
    return preg_match('/\.md$/', $file->getFilename());
}

function get_markdown_headers(SplFileInfo $file): array | bool
{
    $file = $file->open('r');
    $parsing = false;
    $valid = false;
    $headers = [];

    while (! $file->feof()) {
        $line = trim($file->fgets());

        if ($line == '---' && !$parsing) {
            $parsing = true;
        } elseif ($line == '---' && $parsing) {
            $parsing = false;
            $valid = true;
            break;
        } elseif ($parsing && preg_match("/(.*):(.*)/", $line, $matches)) {
            list(, $name, $value) = $matches;
            $headers[trim($name)] = trim($value);
        }
    }

    return $valid ? $headers : false;
}

function has_markdown_headers(SplFileInfo $file): bool
{
    return get_markdown_headers($file) !== false;
}

function update_markdown_headers(SplFileInfo $file): SplFileInfo
{
    //
}
