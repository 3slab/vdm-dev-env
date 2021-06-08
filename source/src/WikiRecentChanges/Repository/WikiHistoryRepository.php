<?php

namespace App\WikiRecentChanges\Repository;

use App\WikiRecentChanges\Entity\WikiHistory;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class WikiHistoryRepository extends ServiceEntityRepository implements WikiHistoryRepositoryInterface
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
     */
    public function getLastEntries(int $max = 3): array
    {
        return $this
            ->createQueryBuilder('wh')
            ->orderBy('wh.timestamp', 'desc')
            ->setMaxResults($max)
            ->getQuery()
            ->getResult();
    }
}