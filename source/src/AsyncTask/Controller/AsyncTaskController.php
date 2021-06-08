<?php

namespace App\AsyncTask\Controller;

use App\AsyncTask\Event\UserActionEvent;
use Psr\EventDispatcher\EventDispatcherInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/asynctask", name="asynctask")
 */
class AsyncTaskController
{
    /**
     * @var EventDispatcherInterface
     */
    protected $dispatcher;

    /**
     * WikiHistoryController constructor.
     * @param EventDispatcherInterface $dispatcher
     */
    public function __construct(
        EventDispatcherInterface $dispatcher
    ) {
        $this->dispatcher = $dispatcher;
    }

    /**
     * @Route("/{userId}/action", name="_action")
     * @param int $userId
     * @return JsonResponse
     */
    public function action(int $userId): JsonResponse
    {
        // Do something in the controller
        // .....

        $event = new UserActionEvent($userId);
        $this->dispatcher->dispatch($event, UserActionEvent::NAME);

        return new JsonResponse(['userId' => $userId]);
    }
}