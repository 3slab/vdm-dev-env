<?php

namespace App\WikiRecentChanges\Controller;

use App\WikiRecentChanges\Manager\WikiHistoryManager;
use App\WikiRecentChanges\Repository\WikiHistoryRepository;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("/wikihistory", name="wiki_history")
 */
class WikiHistoryController
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
     * WikiHistoryController constructor.
     * @param WikiHistoryRepository $repository
     * @param SerializerInterface $serializer
     */
    public function __construct(
        WikiHistoryRepository $repository,
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