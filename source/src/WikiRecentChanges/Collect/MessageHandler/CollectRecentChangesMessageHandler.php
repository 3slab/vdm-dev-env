<?php

namespace App\WikiRecentChanges\Collect\MessageHandler;

use App\WikiRecentChanges\Collect\Message\RecentChangeMessage;
use App\WikiRecentChanges\Collect\Message\WikipediaMessage;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;

class CollectRecentChangesMessageHandler implements MessageSubscriberInterface
{
    /**
     * @var MessageBusInterface
     */
    protected $bus;

    /**
     * @var LoggerInterface $logger
     */
    protected $logger;

    /**
     * @param MessageBusInterface $bus
     * @param LoggerInterface $logger
     */
    public function __construct(
        MessageBusInterface $bus,
        LoggerInterface $logger
    ) {
        $this->bus = $bus;
        $this->logger = $logger;
    }

    /**
     * @param WikipediaMessage $message
     */
    public function __invoke(WikipediaMessage $message)
    {
        $enrichedMessage = RecentChangeMessage::createFrom($message);
        $this->bus->dispatch($enrichedMessage);
    }

    /**
     * {@inheritDoc}
     */
    public static function getHandledMessages(): iterable
    {
        yield WikipediaMessage::class;
    }
}
