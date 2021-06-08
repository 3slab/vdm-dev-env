<?php

namespace App\WikiRecentChanges\Controller;

use App\WikiRecentChanges\Manager\WikiHistoryManager;
use App\WikiRecentChanges\Repository\WikiHistoryMongoRepository;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("/wikihistorymongo", name="wiki_history_mongo")
 */
class WikiHistoryMongoController
{
    /**
     * @var WikiHistoryManager
     */
    protected $manager;

    /**
     * @var SerializerInterface
     */
    protected $serializer;

    /**
     * WikiHistoryMongoController constructor.
     * @param WikiHistoryMongoRepository $repository
     * @param SerializerInterface $serializer
     */
    public function __construct(
        WikiHistoryMongoRepository $repository,
        SerializerInterface $serializer
    ) {
        $this->manager = new WikiHistoryManager($repository);
        $this->serializer = $serializer;
    }

    /**
     * @Route("", name="_list")
     */
    public function list(): JsonResponse
    {
        $items = $this->manager->getLastEntries();
        return new JsonResponse($this->serializer->normalize($items));
    }
}