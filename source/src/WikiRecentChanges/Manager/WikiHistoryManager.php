<?php

namespace App\WikiRecentChanges\Manager;

use App\WikiRecentChanges\Entity\WikiHistory;
use App\WikiRecentChanges\Repository\WikiHistoryRepository;

/**
 * Class WikiHistoryManager
 * @package App\WikiRecentChanges\Manager
 */
class WikiHistoryManager
{
    /**
     * @var WikiHistoryRepository
     */
    protected $repository;

    /**
     * WikiHistoryManager constructor.
     * @param WikiHistoryRepository $repository
     */
    public function __construct(WikiHistoryRepository $repository)
    {
        $this->repository = $repository;
    }

    /**
     * @param int $max
     * @return array
     */
    public function getLastEntries(int $max = 3): array
    {
        return $this->repository->getLastEntries($max);
    }

    /**
     * @return WikiHistory|null
     */
    public function getLatestEntry(): ?WikiHistory
    {
        $results = $this->repository->getLastEntries(1);
        return $results[0] ?: null;
    }
}