# Gang Scheduling

https://www.geeksforgeeks.org/gang-scheduling-in-operating-system/

Scheduling is the process of managing resources (mostly hardware resources like I/O, CPU, memory, etc.) effectively to complete a given set of tasks.

Most common methods are First Come First Serve (FCFS), Shortest Job First (SJF), Round Robin (RR), etc

## What is Gang Scheduling?

- Each task is a gang, so gang scheduling is scheduling each task effectively.
- Differs from other types of scheduling because considers each gang as a unit and schedules them
  - Each gang could require multiple processes/threads on its own
- **How does it work?**
  - uses an Ousterhout matrix
  - ...

## When Is This Needed?

I.e. when you want to queue up job runs for a ML server to process

- Good for when jobs are not time sensitive and you want to save $$
