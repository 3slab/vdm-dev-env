<?php

namespace App\WikiRecentChanges\Repository;

interface WikiHistoryRepositoryInterface
{
    /**
     * @param int $max
     * @return array
     */
    public function getLastEntries(int $max = 3): array;
}