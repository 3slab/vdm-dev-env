<?php

namespace App\SingleCompute\MessageHandler;

use App\SingleCompute\Message\ComputeInputMessage;
use App\SingleCompute\Message\ComputeOutputMessage;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;
use Symfony\Component\Messenger\MessageBusInterface;

/**
 * Class ComputeMessageHandler
 * @package App\SingleCompute\MessageHandler
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

        $outputMessage = ComputeOutputMessage::createFrom($message);
        $this->bus->dispatch($outputMessage);
    }

    /**
     * @return iterable
     */
    public static function getHandledMessages(): iterable
    {
        yield ComputeInputMessage::class;
    }
}
