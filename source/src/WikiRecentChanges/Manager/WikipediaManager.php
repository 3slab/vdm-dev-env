<?php

namespace App\WikiRecentChanges\Manager;

use Symfony\Component\Serializer\Encoder\JsonDecode;
use Symfony\Contracts\HttpClient\HttpClientInterface;

class WikipediaManager
{
    public const RECENTCHANGES_API = '/w/api.php?action=query&list=recentchanges&rclimit=1&format=json';
    public const REVISION_API = '/w/api.php?action=query&prop=revisions&pageids=%s&rvstartid=%s&rvendid=%s&format=json';

    /**
     * @var HttpClientInterface
     */
    protected $httpClient;

    /**
     * @var JsonDecode
     */
    protected $decoder;

    /**
     * WikipediaManager constructor.
     * @param HttpClientInterface $wikipediaClient
     */
    public function __construct(HttpClientInterface $wikipediaClient)
    {
        $this->httpClient = $wikipediaClient;
        $this->decoder = new JsonDecode();
    }

    /**
     * @return HttpClientInterface
     */
    public function getHttpClient(): HttpClientInterface
    {
        return $this->httpClient;
    }

    /**
     * @return array
     * @throws \Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface
     */
    public function getLastRecentChange(): array
    {
        $result = $this->request('GET', static::RECENTCHANGES_API);
        return $result['query']['recentchanges'][0];
    }

    /**
     * @param int $pageId
     * @param int $revId
     * @return array
     * @throws \Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface
     */
    public function getRevision(int $pageId, int $revId): array
    {
        $result = $this->request('GET', sprintf(static::REVISION_API, $pageId, $revId, $revId));
        return $result['query']['pages'][$pageId]['revisions'][0];
    }

    /**
     * @param string $method
     * @param string $uri
     * @return array
     * @throws \Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface
     * @throws \Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface
     */
    protected function request(string $method, string $uri): array
    {
        $response = $this->httpClient->request($method, $uri);

        return $this->decoder->decode(
            $response->getContent(),
            'json',
            [JsonDecode::ASSOCIATIVE => true]
        );
    }
}