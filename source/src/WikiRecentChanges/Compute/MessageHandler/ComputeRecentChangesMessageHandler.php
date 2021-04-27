<?php

namespace App\WikiRecentChanges\Compute\MessageHandler;

use App\WikiRecentChanges\Collect\Message\RecentChangeMessage;
use App\WikiRecentChanges\Compute\Message\RevisionMessage;
use App\WikiRecentChanges\Manager\WikipediaManager;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;

class ComputeRecentChangesMessageHandler implements MessageSubscriberInterface
{
    /**
     * @var WikipediaManager
     */
    protected $manager;

    /**
     * @var MessageBusInterface
     */
    protected $bus;

    /**
     * @var LoggerInterface $logger
     */
    protected $logger;

    /**
     * @param HttpClientInterface $wikipediaClient
     * @param MessageBusInterface $bus
     * @param LoggerInterface $logger
     */
    public function __construct(
        WikipediaManager $manager,
        MessageBusInterface $bus,
        LoggerInterface $logger
    ) {
        $this->manager = $manager;
        $this->bus = $bus;
        $this->logger = $logger;
    }

    /**
     * @param RecentChangeMessage $message
     */
    public function __invoke(RecentChangeMessage $message)
    {
        $payload = $message->getPayload();
        $pageId = $payload['pageid'];
        $revId = $payload['revid'];

        $revision = $this->manager->getRevision($pageId, $revId);

        $payload = $message->getPayload();
        $payload['comment'] = $revision['comment'];
        $payload['user'] = $revision['user'];

        $payload = $this->renameKeys($payload);

        $enrichedMessage = RevisionMessage::createFrom($message, $payload);
        $envelope = new Envelope($enrichedMessage);
        $this->bus->dispatch($envelope);
    }

    /**
     * @param array $payload
     * @return array
     */
    protected function renameKeys(array $payload): array
    {
        $payload['pageId'] = $payload['pageid'];
        unset($payload['pageid']);

        $payload['revId'] = $payload['revid'];
        unset($payload['revid']);

        $payload['oldRevId'] = $payload['old_revid'];
        unset($payload['old_revid']);

        $payload['rcId'] = $payload['rcid'];
        unset($payload['rcid']);

        return $payload;
    }

    /**
     * {@inheritDoc}
     */
    public static function getHandledMessages(): iterable
    {
        yield RecentChangeMessage::class;
    }
}
