<?php

namespace App\WikiRecentChanges\Store\MessageHandler;

use App\WikiRecentChanges\Compute\Message\RevisionMessage;
use App\WikiRecentChanges\Store\Message\HistoryMessage;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;

class StoreRecentChangesMessageHandler implements MessageSubscriberInterface
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
     * @param RevisionMessage $message
     */
    public function __invoke(RevisionMessage $message)
    {
        $historyMessage = HistoryMessage::createFrom($message);
        $envelope = new Envelope($historyMessage);
        $this->bus->dispatch($envelope);
    }

    /**
     * {@inheritDoc}
     */
    public static function getHandledMessages(): iterable
    {
        yield RevisionMessage::class;
    }
}
