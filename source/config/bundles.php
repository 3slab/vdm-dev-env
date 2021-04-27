<?php

return [
    Symfony\Bundle\FrameworkBundle\FrameworkBundle::class => ['all' => true],
    Symfony\Bundle\MonologBundle\MonologBundle::class => ['all' => true],
    Vdm\Bundle\LibraryBundle\VdmLibraryBundle::class => ['all' => true],
    Vdm\Bundle\LibraryHttpTransportBundle\VdmLibraryHttpTransportBundle::class => ['all' => true],
    Doctrine\Bundle\DoctrineBundle\DoctrineBundle::class => ['all' => true],
    Vdm\Bundle\LibraryDoctrineOrmTransportBundle\VdmLibraryDoctrineOrmTransportBundle::class => ['all' => true],
    Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle::class => ['all' => true],
    Koco\Kafka\KocoKafkaBundle::class => ['all' => true],
];
