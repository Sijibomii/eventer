import createError  from "http-errors";
import express, {Request, Response, NextFunction, Errback}  from "express";
import  indexRouter  from './routes';

const app = express();

app.use('/', indexRouter);

  // catch 404 and forward to error handler
app.use(function(__, _, next) {
  next(createError(404));
});

  // error handler
app.use(function(err: Errback , req: Request, res:Response, next: NextFunction) {
    //handle errors here
    //for now so it'll let me compile
    console.log(err)
    console.log(req)
    console.log(res)
    console.log(next)
});


export { app };


