<?php

namespace App\WikiRecentChanges\Repository;

use App\WikiRecentChanges\Document\WikiHistory;
use Doctrine\Bundle\MongoDBBundle\ManagerRegistry;
use Doctrine\Bundle\MongoDBBundle\Repository\ServiceDocumentRepository;

class WikiHistoryMongoRepository extends ServiceDocumentRepository implements WikiHistoryRepositoryInterface
{
    /**
     * WikiHistoryRepository constructor.
     * @param ManagerRegistry $registry
     */
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, WikiHistory::class);
    }

    /**
     * @param int $max
     * @return array
     * @throws \Doctrine\ODM\MongoDB\MongoDBException
     */
    public function getLastEntries(int $max = 3): array
    {
        return $this
            ->createQueryBuilder()
            ->sort('timestamp', 'desc')
            ->limit($max)
            ->getQuery()
            ->execute()
            ->toArray();
    }
}