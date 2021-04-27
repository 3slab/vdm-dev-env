<?php

namespace App\WikiRecentChanges\Collect\Executor;

use App\WikiRecentChanges\Collect\Message\WikipediaMessage;
use App\WikiRecentChanges\Manager\WikipediaManager;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Envelope;
use Vdm\Bundle\LibraryHttpTransportBundle\Executor\AbstractHttpExecutor;

class WikiRecentChangeHttpExecutor extends AbstractHttpExecutor
{
    /**
     * @var WikipediaManager
     */
    protected $manager;

    /**
     * WikiRecentChangeHttpExecutor constructor.
     *
     * @param WikipediaManager $wikipediaManager
     * @param LoggerInterface|null $vdmLogger
     */
    public function __construct(
        WikipediaManager $wikipediaManager,
        LoggerInterface $vdmLogger = null
    ) {
        parent::__construct($wikipediaManager->getHttpClient(), $vdmLogger);

        $this->manager = $wikipediaManager;
    }

    /**
     * @param string $dsn
     * @param string $method
     * @param array $options
     * @return iterable
     * @throws \Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface
     */
    public function execute(string $dsn, string $method, array $options): iterable
    {
        $payload = $this->manager->getLastRecentChange();
        while (!isset($payload['revid']) || $payload['revid'] === 0) {
            $this->logger->info(sprintf('No revid in record %s. Looking for a newer change.', $payload['rcid']));
            $payload = $this->manager->getLastRecentChange();
        }
        $message = new WikipediaMessage($payload);
        yield new Envelope($message);
    }
}
