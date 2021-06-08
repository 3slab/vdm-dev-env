<?php

namespace App\AsyncTask\EventSubscriber;

use App\AsyncTask\Event\UserActionEvent;
use App\AsyncTask\Message\CompileStatsMessage;
use App\AsyncTask\Message\SendNotificationMessage;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;

class UserActionEventSubscriber implements EventSubscriberInterface
{
    /**
     * @var MessageBusInterface
     */
    protected $bus;

    /**
     * UserActionEventSubscriber constructor.
     * @param MessageBusInterface $bus
     */
    public function __construct(MessageBusInterface $bus)
    {
        $this->bus = $bus;
    }

    /**
     * {@inheritDoc}
     */
    public static function getSubscribedEvents()
    {
        return [
            UserActionEvent::NAME => 'onUserAction',
        ];
    }

    /**
     * @param UserActionEvent $event
     */
    public function onUserAction(UserActionEvent $event)
    {
        $userId = $event->getUserId();

        $statMessage = new CompileStatsMessage($userId);
        $this->bus->dispatch($statMessage);

        $notificationMessage = new SendNotificationMessage($userId);
        $this->bus->dispatch($notificationMessage);
    }
}
