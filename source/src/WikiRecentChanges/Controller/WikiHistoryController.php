<?php

namespace App\WikiRecentChanges\Controller;

use App\WikiRecentChanges\Manager\WikiHistoryManager;
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
     * @param WikiHistoryManager $manager
     * @param SerializerInterface $serializer
     */
    public function __construct(
        WikiHistoryManager $manager,
        SerializerInterface $serializer
    ) {
        $this->manager = $manager;
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