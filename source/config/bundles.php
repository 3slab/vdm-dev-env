<?php

return [
    Symfony\Bundle\FrameworkBundle\FrameworkBundle::class => ['all' => true],
    Symfony\Bundle\MonologBundle\MonologBundle::class => ['all' => true],
    Doctrine\Bundle\DoctrineBundle\DoctrineBundle::class => ['all' => true],
    Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle::class => ['all' => true],
    Doctrine\Bundle\MongoDBBundle\DoctrineMongoDBBundle::class => ['all' => true],
    Koco\Kafka\KocoKafkaBundle::class => ['all' => true],
    Vdm\Bundle\LibraryBundle\VdmLibraryBundle::class => ['all' => true],
    Vdm\Bundle\LibraryHttpTransportBundle\VdmLibraryHttpTransportBundle::class => ['all' => true],
    Vdm\Bundle\LibraryDoctrineTransportBundle\VdmLibraryDoctrineTransportBundle::class => ['all' => true],
    Vdm\Bundle\HealthcheckBundle\VdmHealthcheckBundle::class => ['all' => true],
    Vdm\Bundle\PrometheusBundle\VdmPrometheusBundle::class => ['all' => true],
    Vdm\Bundle\VersionBundle\VdmVersionBundle::class => ['all' => true],
];
