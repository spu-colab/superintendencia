<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        'App\Console\Commands\GerarBackupSistemas'
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $logFile = base_path('backup_log.txt');

        #/*
        $schedule->command('backup:run')
            ->dailyAt('21:00')
            ->sendOutputTo($logFile);
        #*/

        #/*
        $schedule->command('backup:clean')
            ->dailyAt('22:00')
            ->sendOutputTo($logFile);
        #*/

        #/*
        $schedule->command('spu:backup')
        ->dailyAt('23:00')
            ->sendOutputTo($logFile);
        #*/
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
