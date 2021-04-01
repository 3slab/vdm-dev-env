<?php

namespace App\MessageHandler;

use App\Message\ComputeInputMessage;
use App\Message\ComputeOutputMessage;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;

/**
 * Class ComputeMessageHandler
 * @package App\MessageHandler
 */
class ComputeMessageHandler implements MessageSubscriberInterface
{
    /**
     * @var MessageBusInterface
     */
    protected $bus;

    /**
     * ComputeMessageHandler constructor.
     * @param MessageBusInterface $bus
     */
    public function __construct(MessageBusInterface $bus)
    {
        $this->bus = $bus;
    }

    /**
     * @param ComputeInputMessage $message
     */
    public function __invoke(ComputeInputMessage $message)
    {
        $payload = $message->getPayload();
        $payload['counter']++;
        $message->setPayload($payload);

        $this->bus->dispatch(ComputeOutputMessage::createFrom($message));
    }

    /**
     * @return iterable
     */
    public static function getHandledMessages(): iterable
    {
        yield ComputeInputMessage::class;
    }
}
