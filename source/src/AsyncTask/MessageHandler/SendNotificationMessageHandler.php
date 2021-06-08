<?php

namespace App\AsyncTask\MessageHandler;

use App\AsyncTask\Message\SendNotificationMessage;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;

class SendNotificationMessageHandler implements MessageSubscriberInterface
{
    /**
     * @var LoggerInterface $logger
     */
    protected $logger;

    /**
     * @param LoggerInterface $logger
     */
    public function __construct(
        LoggerInterface $logger
    ) {
        $this->logger = $logger;
    }

    /**
     * @param SendNotificationMessage $message
     */
    public function __invoke(SendNotificationMessage $message)
    {
        echo PHP_EOL;
        echo PHP_EOL;
        echo PHP_EOL;
        echo 'SendNotificationMessageHandler' . PHP_EOL;
        echo '----------------------------' . PHP_EOL;
        echo 'You can read the message and do anything with the data in it asynchronously' . PHP_EOL;
        echo '----------------------------' . PHP_EOL;
        dump($message);
        echo '----------------------------' . PHP_EOL;
        echo PHP_EOL;
        echo PHP_EOL;
        echo PHP_EOL;
    }

    /**
     * {@inheritDoc}
     */
    public static function getHandledMessages(): iterable
    {
        yield SendNotificationMessage::class;
    }
}
