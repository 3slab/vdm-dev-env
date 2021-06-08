<?php

namespace App\AsyncTask\Message;

class CompileStatsMessage
{
    /**
     * @var int
     */
    protected $userId;

    /**
     * CompileStatsMessage constructor.
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

    /**
     * @param int $userId
     * @return CompileStatsMessage
     */
    public function setUserId(int $userId): self
    {
        $this->userId = $userId;

        return $this;
    }
}
