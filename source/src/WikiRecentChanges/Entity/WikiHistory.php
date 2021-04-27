<?php

namespace App\WikiRecentChanges\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity()
 */
class WikiHistory
{
    /**
     * @var int|null
     *
     * @ORM\Id()
     * @ORM\Column(type="integer")
     */
    protected $rcId;

    /**
     * @var string|null
     *
     * @ORM\Column(type="string", length=255)
     */
    protected $type;

    /**
     * @var int|null
     *
     * @ORM\Column(type="integer")
     */
    protected $ns;

    /**
     * @var string|null
     *
     * @ORM\Column(type="string", length=255)
     */
    protected $title;

    /**
     * @var int|null
     *
     * @ORM\Column(type="integer")
     */
    protected $pageId;

    /**
     * @var int|null
     *
     * @ORM\Column(type="integer")
     */
    protected $revId;

    /**
     * @var int|null
     *
     * @ORM\Column(type="integer")
     */
    protected $oldRevId;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(type="datetime")
     */
    protected $timestamp;

    /**
     * @var string|null
     *
     * @ORM\Column(type="string", length=255)
     */
    protected $comment;

    /**
     * @var string|null
     *
     * @ORM\Column(type="string", length=255)
     */
    protected $user;

    /**
     * @return string|null
     */
    public function getType(): ?string
    {
        return $this->type;
    }

    /**
     * @param string|null $type
     * @return WikiHistory
     */
    public function setType(?string $type): self
    {
        $this->type = $type;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getNs(): ?int
    {
        return $this->ns;
    }

    /**
     * @param int|null $ns
     * @return WikiHistory
     */
    public function setNs(?int $ns): self
    {
        $this->ns = $ns;

        return $this;
    }

    /**
     * @return string|null
     */
    public function getTitle(): ?string
    {
        return $this->title;
    }

    /**
     * @param string|null $title
     * @return WikiHistory
     */
    public function setTitle(?string $title): self
    {
        $this->title = $title;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getPageId(): ?int
    {
        return $this->pageId;
    }

    /**
     * @param int|null $pageId
     * @return WikiHistory
     */
    public function setPageId(?int $pageId): self
    {
        $this->pageId = $pageId;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getRevId(): ?int
    {
        return $this->revId;
    }

    /**
     * @param int|null $revId
     * @return WikiHistory
     */
    public function setRevId(?int $revId): self
    {
        $this->revId = $revId;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getOldRevId(): ?int
    {
        return $this->oldRevId;
    }

    /**
     * @param int|null $oldRevId
     */
    public function setOldRevId(?int $oldRevId): self
    {
        $this->oldRevId = $oldRevId;

        return $this;
    }

    /**
     * @return int|null
     */
    public function getRcId(): ?int
    {
        return $this->rcId;
    }

    /**
     * @param int|null $rcId
     */
    public function setRcId(?int $rcId): self
    {
        $this->rcId = $rcId;

        return $this;
    }

    /**
     * @return \DateTime|null
     */
    public function getTimestamp(): ?\DateTime
    {
        return $this->timestamp;
    }

    /**
     * @param \DateTime|null $timestamp
     * @return WikiHistory
     */
    public function setTimestamp(?\DateTime $timestamp): self
    {
        $this->timestamp = $timestamp;

        return $this;
    }

    /**
     * @return string|null
     */
    public function getComment(): ?string
    {
        return $this->comment;
    }

    /**
     * @param string|null $comment
     * @return WikiHistory
     */
    public function setComment(?string $comment): self
    {
        $this->comment = $comment;

        return $this;
    }

    /**
     * @return string|null
     */
    public function getUser(): ?string
    {
        return $this->user;
    }

    /**
     * @param string|null $user
     * @return WikiHistory
     */
    public function setUser(?string $user): self
    {
        $this->user = $user;

        return $this;
    }
}
