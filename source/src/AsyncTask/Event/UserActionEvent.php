<?php

namespace App\AsyncTask\Event;

use Symfony\Contracts\EventDispatcher\Event;

class UserActionEvent extends Event
{
    public const NAME = 'user.action';

    /**
     * @var int
     */
    protected $userId;

    /**
     * UserActionEvent constructor.
     * @param int $userId
     */
    public function __construct(int $userId)
    {
        $this->userId = $userId;
    }

    /**
     * @return int
     */
    public function getUserId(): int
    {
        return $this->userId;
    }
}